import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';

import AppState from '../../models/AppState'
import OrderRepository from '../../repositories/OrderRepository'

class NewOrderForm extends React.Component {
  // state ---------------------------------------------------------------------
  state = {
    order: {
      collect_method: 'timeline',
      protect_reply: false,
      start_message: 'hoge',
    }
  }

  // handler -------------------------------------------------------------------
  createOrder = async () => {
    const credentials = this.props.appState.state.credentials
    const order = this.state.order

    orderRepository = new OrderRepository(credentials)
    await orderRepository.create(order)

    this.props.navigation.navigate('OrderStatusScreen')
  };

  // render --------------------------------------------------------------------
  render() {
    return (
      <Button title="Create Order" onPress={this.createOrder} />
    );
  }
}

export default NewOrderForm;
