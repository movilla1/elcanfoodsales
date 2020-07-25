import { User } from '../models/user';

export class AuthResultData  {
  private token = '';
  private user: User;
  constructor(response) {
    this.token = response.auth_token;
    this.user = response.user;
  }

  public getUser = () => this.user;
  public getToken = () => this.token;
}
