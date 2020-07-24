import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { User } from './models/user';

@Injectable({
  providedIn: 'root'
})

export class AuthService {
  private LoginUrl = 'http://localhost:3000/api/v1/authenticate';
  constructor(private http: HttpClient) { }

  doLogin = (userData: User) => this.http.post(this.LoginUrl, {email: userData.email, password: userData.password});

}
