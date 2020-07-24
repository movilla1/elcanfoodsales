import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LoginData } from './models/login_data';

@Injectable({
  providedIn: 'root'
})

export class AuthService {
  private LoginUrl = 'http://localhost:3000/api/v1/authenticate';
  constructor(private http: HttpClient) { }

  doLogin = (userData: LoginData) => this.http.post(this.LoginUrl, userData);

}
