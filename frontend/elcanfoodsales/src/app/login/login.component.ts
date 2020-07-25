import { Component, OnInit } from '@angular/core';
import { LoginData } from '../models/login_data';
import { AuthService } from '../auth.service';
import { AuthResultData } from '../models/auht_result_data';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {
  loginUserData = new LoginData();
  errorMessage = '';
  constructor(private auth: AuthService) { }

  ngOnInit(): void {
  }

  loginUser(): void {
    this.auth.doLogin(this.loginUserData).subscribe (
      res => {
        const AuthResult = new AuthResultData(res);
        localStorage.setItem('token', AuthResult.getToken());
        localStorage.setItem('User', AuthResult.getUser().toString());
        console.log(res);
      },
      err => this.errorMessage = err.message
    );
  }
}
