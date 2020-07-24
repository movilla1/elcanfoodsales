import { Component, OnInit } from '@angular/core';
import { User } from '../models/user';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {
  loginUserData = new User('', '');

  constructor() { }

  ngOnInit(): void {
  }

  loginUser(): void {
    
  }
}
