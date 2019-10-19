import React from 'react'
import { Subscribe } from 'unstated'
import { Container, Content } from 'native-base'

import AppState from '../../models/AppState'
import MyHeader from '../layout/MyHeader'
import OrderStatusView from './OrderStatusView'

class ShowOrderScreenContainer extends React.Component {
  render() {
    const { appState } = this.props
    return (
      <Container>
        <MyHeader />
        <Content>
          <OrderStatusView appState={appState} />
        </Content>
      </Container>
    )
  }
}

class ShowOrderScreen extends React.Component {
  render() {
    const { navigation } = this.props
    return (
      <Subscribe to={[AppState]}>
        {
          appState => (
            <ShowOrderScreenContainer appState={appState} navigation={navigation} />
          )
        }
      </Subscribe>
    );
  }
}

export default ShowOrderScreen;
