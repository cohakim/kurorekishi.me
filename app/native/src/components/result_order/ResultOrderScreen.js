import React from 'react'
import { Subscribe } from 'unstated'
import { Container, Content } from 'native-base'

import AppState from '../../models/AppState'
import MyHeader from '../layout/MyHeader'
import OrderResultView from './OrderResultView'

class ResultOrderScreenContainer extends React.Component {
  render() {
    const { appState } = this.props
    return (
      <Container>
        <MyHeader />
        <Content>
          <OrderResultView appState={appState} />
        </Content>
      </Container>
    )
  }
}

class ResultOrderScreen extends React.Component {
  render() {
    const { navigation } = this.props
    return (
      <Subscribe to={[AppState]}>
        {
          appState => (
            <ResultOrderScreenContainer appState={appState} navigation={navigation} />
          )
        }
      </Subscribe>
    );
  }
}

export default ResultOrderScreen;
