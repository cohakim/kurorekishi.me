def sign_in(user = nil)
  set_omniauth(user)

  visit root_path
  within first '.wrapped-content' do
    click_on 'ツイッターでログイン'
  end
end
