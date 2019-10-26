import React from 'react'
import { Subscribe } from 'unstated'
import { Container, Content } from 'native-base'

import AppState from '../../models/AppState'
import MyHeader from '../layout/MyHeader'
import NewOrderForm from './NewOrderForm'

class NewOrderScreenContainer extends React.Component {
  render() {
    const { appState } = this.props
    return (
      <Container>
        <MyHeader />
        <Content>
          <NewOrderForm appState={appState} />
        </Content>
      </Container>
    )
  }
}

class NewOrderScreen extends React.Component {
  render() {
    const { navigation } = this.props
    return (
      <Subscribe to={[AppState]}>
        {
          appState => (
            <NewOrderScreenContainer appState={appState} navigation={navigation} />
          )
        }
      </Subscribe>
    );
  }
}

export default NewOrderScreen;
