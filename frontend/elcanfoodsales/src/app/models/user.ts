export class User {
  public email: string;
  public password: string;
  private firstName: string;
  private lastName: string;
  private role: string;

  constructor(email: string, password: string) {
    this.email = email;
    this.password = password;
  }

  setUserDetails = (fName: string, lName: string, role: string): void =>  {
    this.firstName = fName;
    this.lastName = lName;
    this.role = role;
  }

  getFullName = (): string => this.firstName + ' ' + this.lastName;

  getFirstName = (): string => this.firstName;

  getLastName = (): string => this.lastName;

  isAdmin = (): boolean => (this.role === 'admin');
}