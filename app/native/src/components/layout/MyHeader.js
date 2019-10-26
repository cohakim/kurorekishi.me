import React from 'react'
import { Header, Left, Body, Right, Button, Icon, Title } from 'native-base'

class MyHeader extends React.Component {
  render() {
    return(
      <Header noLeft>
        <Left>
          <Button transparent>
            <Icon name='menu' />
          </Button>
        </Left>
        <Body style={{flex: 3}}>
          <Title>黒歴史クリーナー</Title>
        </Body>
        <Right>
        </Right>
      </Header>
    );
  }
}

export default MyHeader;
