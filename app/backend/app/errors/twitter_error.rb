module TwitterError
  extend ActiveSupport::Concern

  class RetryableError < StandardError; end
  class UnretryableError < StandardError; end

  NETWORK_ERRORS = [OpenSSL::SSL::SSLError, SocketError, EOFError, Errno::ECONNRESET]
  TIMEOUT_ERRORS = [Timeout::Error]
  CSV_ERRORS     = [CSV::MalformedCSVError, ArgumentError]

  included do
    # NOTE: 定義の逆順でマッチ
    rescue_from *NETWORK_ERRORS, with: :handle_retryable_error
    rescue_from *TIMEOUT_ERRORS, with: :handle_retryable_error
    rescue_from *CSV_ERRORS,     with: :handle_unretryable_error
    rescue_from Twitter::Error do |exception|
      if (exception.message == 'execution expired' || exception.message == 'Net::OpenTimeout')
        handle_retryable_error(exception)
      else
        handle_unretryable_error(exception)
      end
    end
    rescue_from Twitter::Error::ServerError, with: :handle_retryable_error
    rescue_from Twitter::Error::ClientError, with: :handle_unretryable_error
  end

  def handle_retryable_error(exception)
    raise RetryableError, exception
  end

  def handle_unretryable_error(exception)
    raise UnretryableError, exception
  end
end
