import applyConverters from 'axios-case-converter';
import axios from 'axios';

class OrderRepository {
  // ===========================================================================
  constructor(credentials) {
    const client = axios.create({
      baseURL: 'http://localhost:3001/cleaner',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${credentials.applicationToken}`
      }
    })
    this.client = applyConverters(client)
  }

  // ===========================================================================
  find_active = async () => {
    const response = await this.client.get('/v1/order')
    return response.data
  }

  // ===========================================================================
  create = async (order) => {
    const response = await this.client.post('/v1/order', order)
    return response.data
  }
}

export default OrderRepository;
