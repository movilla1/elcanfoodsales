import { Component, OnInit } from '@angular/core';
import { LoginData } from '../models/login_data';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {
  loginUserData = new LoginData();

  constructor(private auth: AuthService) { }

  ngOnInit(): void {
  }

  loginUser(): void {
    this.auth.doLogin(this.loginUserData).subscribe (
      res => console.log(res),
      err => console.log(err)
    );
  }
}
