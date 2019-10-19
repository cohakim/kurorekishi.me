import React from 'react'
import { Provider } from 'unstated'
import {
  createSwitchNavigator,
  createAppContainer,
} from 'react-navigation'
import { StyleProvider } from 'native-base'
import getTheme from './theme/components'
import material from './theme/variables/material'
import { AppLoading } from 'expo'
import * as Font from 'expo-font'
import { Ionicons } from '@expo/vector-icons';

import HomeScreen from './home/HomeScreen'
import NewOrderScreen from './new_order/NewOrderScreen'
import ShowOrderScreen from './show_order/ShowOrderScreen';
import ResultOrderScreen from './result_order/ResultOrderScreen';

const AppNavigator = createSwitchNavigator(
  {
    HomeScreen,
    NewOrderScreen,
    ShowOrderScreen,
    ResultOrderScreen,
  },
  {
    initialRouteName: 'ResultOrderScreen'
  }
);

const AppContainer = createAppContainer(AppNavigator);

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isReady: false,
    };
  }

  async componentDidMount() {
    await Font.loadAsync({
      Roboto: require("../../node_modules/native-base/Fonts/Roboto.ttf"),
      Roboto_medium: require("../../node_modules/native-base/Fonts/Roboto_medium.ttf"),
      ...Ionicons.font
    })
    this.setState({ isReady: true });
  }

  render() {
    if (!this.state.isReady) {
      return <AppLoading />;
    }

    return(
      <Provider>
        <StyleProvider style={getTheme(material)}>
          <AppContainer />
        </StyleProvider>
      </Provider>
    );
  }
}
