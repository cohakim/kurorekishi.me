import React from 'react';
import { Button, Text } from 'native-base'
import { Linking } from 'expo'
import * as WebBrowser from 'expo-web-browser';

class LoginWithTwitterButton extends React.Component {
  // handler -------------------------------------------------------------------
  loginWithTwitter = async () => {
    Linking.addEventListener('url', this.webBrowserDidRedirect);

    const linkUrl = Linking.makeUrl()
    await WebBrowser.openBrowserAsync(
      `http://localhost:3001/cleaner/v1/auth/twitter?linkingurl=${linkUrl}`
    )

    Linking.removeEventListener('url', this.webBrowserDidRedirect);
  };

  webBrowserDidRedirect = (event) => {
    WebBrowser.dismissBrowser()
    let { path, queryParams } = Linking.parse(event.url)
    this.props.onPressCallback(queryParams)
  }

  // render --------------------------------------------------------------------
  render() {
    return (
      <Button onPress={this.loginWithTwitter} ><Text>ツイッターでログイン</Text></Button>
    );
  }
}

export default LoginWithTwitterButton;
