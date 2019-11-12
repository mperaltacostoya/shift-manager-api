# Shift Manager Api

The api allows multiple administrators to keep a record of employees' working hours. In order to accomplish that, administrator can create a user shift with a param called check in time, that represent the date and time a shift start. In the moment the user leave work, the current open shift ends so the shift can be updated with an check out time. The api is flexible to change or delete previous shifts times in case any shift needs to be corrected. The only restriction is that an administrator can't create a new shift if the user already has an open shift. This shift must be closed (update its check out time) in order to create a new one.

## How it works?

* Administrator are users with the role 'admin'. This user must be created at server side because the api doesn't allow to create administrator from outside.

* Administrator can create new users, update their fields, and even delete users from the system. The users created by administrator will have the 'employee' role.

* Administrator are responsible to share the password with the employees created so they can access to the system.

* Administrator can create new shifts, update their fields and delete them from the system at any time.

* Shift are not associated to days. In case a worker starts his job on monday 20:00 hours and ends on tuesday at 04:00 hours, the system allows to keep record of this 'day of work'.

* Users with role 'employee' can sign up, although the information they provide can only be changed later by an administrator. This may include the password.

* Users with role 'employee' can only see their own information.

## Documentation

Full api documentation can be found [here](https://documenter.getpostman.com/view/4921859/SW7UaVJQ)

## How to test it?

The api is currently deployed at [https://calm-garden-21850.herokuapp.com/](https://calm-garden-21850.herokuapp.com/) and can be tested with curl or postman or other similar, by following the Documentation.

The current seed contain one administrator user. The credentials to test with that user are:
```
email: admin@example.org
password: hello123
```

The api can be tested locally also. Keep in mind that it use postgres as database. General instructions:
1. Clone the repo

```
git clone https://github.com/mperaltacostoya/shift-manager-api.git
```
2. Install dependecies

```
bundle install
```
3. Create, migrate and seed the database

```
rake db:create db:migrate db:seed
```
4. Start the server

```
rails s
```

The same credentials can be used to test with the administrator user.
