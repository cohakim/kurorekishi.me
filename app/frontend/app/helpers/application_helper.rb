module ApplicationHelper
  def flash_messages
    if alert.present?
      tag.div class: 'wrapped-content' do
        tag.div class: 'panel radius lightpurple text-center' do
          alert
        end
      end
    elsif notice.present?
      tag.div class: 'wrapped-content' do
        tag.div class: 'panel radius success text-center' do
          notice
        end
      end
    end
  end
end
