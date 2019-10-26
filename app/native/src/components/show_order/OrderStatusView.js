import React from 'react';
import { Button } from 'react-native';

import AppState from '../../models/AppState'
import OrderRepository from '../../repositories/OrderRepository'

class OrderStatusView extends React.Component {
  // state ---------------------------------------------------------------------

  // handler -------------------------------------------------------------------
  // componentDidMount = () => {
  //   this.timerID = setInterval(
  //     () => this.getOrder(),
  //     10000
  //   )
  // }

  // componentWillUnmount = () => {
  //   clearInterval(this.timerID);
  // }

  // getOrder = async () => {
  //   const credentials = this.props.appStateContainer.state.credentials

  //   orderRepository = new OrderRepository(credentials)
  //   const order = await orderRepository.find_active()

  //   this.setState({ order: order })
  // };

  // render --------------------------------------------------------------------
  render() {
    return (
      <Button title="Order Status" />
    );
  }
}

export default OrderStatusView;
