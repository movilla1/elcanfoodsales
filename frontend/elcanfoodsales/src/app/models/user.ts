export class User {
  public email: string;
  public firstName: string;
  public lastName: string;
  private role: string;

  constructor(email: string) {
    this.email = email;
  }

  setUserDetails = (fName: string, lName: string, role: string): void =>  {
    this.firstName = fName;
    this.lastName = lName;
    this.role = role;
  }

  getFullName = (): string => this.firstName + ' ' + this.lastName;

  isAdmin = (): boolean => (this.role === 'admin');
}