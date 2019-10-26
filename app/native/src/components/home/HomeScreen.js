import React from 'react'
import { Subscribe } from 'unstated'
import { Container, Content, View, H1, H3, Text, Icon, Card, CardItem, Body } from 'native-base'

import AppState from '../../models/AppState'
import MyHeader from '../layout/MyHeader'
import LoginWithTwitterButton from './LoginWithTwitterButton'

class HomeScreenContainer extends React.Component {
  loginWithTwitterCallback = (queryParams) => {
    if (!queryParams.application_token) {
      throw new Error('application_token not returned');
    }
    this.props.appState.setApplicationToken(queryParams.application_token);
    this.props.navigation.navigate('NewOrderScreen')
  }

  render() {
    return (
      <Container>
        <MyHeader />
        <Content>
          <View>
            <View style={{ alignItems: 'center', marginTop: 10 }}>
              <H1>呪われしツイートを</H1>
              <H1>一括削除！</H1>
            </View>
            <View style={{ alignItems: 'center', marginTop: 10 }}>
              <LoginWithTwitterButton onPressCallback={this.loginWithTwitterCallback} />
            </View>
            <View style={{ alignItems: 'center', width: '100%', marginTop: 25, padding: 20, backgroundColor: '#f4f4f4' }}>
              <Text>
                黒歴史クリーナーはツイートを
              </Text>
              <Text>一括で削除できるサービスです！</Text>
            </View>
            <View style={{ alignItems: 'center', width: '100%', marginTop: 25 }}>
              <H3>Features</H3>
              <Card transparent style={{ alignItems: 'center' }}>
                <CardItem>
                  <Text>
                    <Icon name='alarm' style={{ fontSize: 60, width: '100%' }} />
                  </Text>
                </CardItem>
                <CardItem>
                <View style={{ alignItems: 'center' }}>
                  <Text>簡単登録、高速削除！</Text>
                  <Text>1分で始められ、10分で終わります</Text>
                </View>
                </CardItem>
              </Card>
              <Card transparent style={{ alignItems: 'center' }}>
                <CardItem>
                  <Text>
                    <Icon name='battery-charging' style={{ fontSize: 60, width: '100%' }} />
                  </Text>
                </CardItem>
                <CardItem>
                <View style={{ alignItems: 'center' }}>
                  <Text> バックグラウンド実行！</Text>
                  <Text>削除が始まればブラウザを起動しておく</Text>
                  <Text>必要はありません</Text>
                </View>
                </CardItem>
              </Card>
            </View>
          </View>
        </Content>
      </Container>
    )
  }
}

// =============================================================================

class HomeScreen extends React.Component {
  render() {
    const { navigation } = this.props
    return (
      <Subscribe to={[AppState]}>
        {
          appState => (
            <HomeScreenContainer appState={appState} navigation={navigation} />
          )
        }
      </Subscribe>
    );
  }
}

export default HomeScreen;
