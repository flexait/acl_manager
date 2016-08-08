# AclManager

[![Code Climate](https://codeclimate.com/github/flexait/acl_manager/badges/gpa.svg)](https://codeclimate.com/github/flexait/acl_manager)

## Installation
1. Install the acl_manager gem: `gem install 'acl_manager'` or put it inside your Gemfile: `gem 'acl_manager'`
2. Add the acl_manager module into devise inside your model: `devise :database_authenticatable, :registerable, ..., :acl_manager`

3. Install the migrations. run:  `rails g acl_manager MODEL`

4. Open up your console and build the acls
    `AclManager::Acl.build_all!`

5. Create your first role. eg: Admin
  ```
  AclManager::Role.create(name: 'admin', active: true, description: 'gives users     admin access')
  role = AclManager::Role.first
  role.acls << AclManager::Acl.first
  user = User.first
  user.roles << role
  ```
6. Add Acl Manager filter to your controllers

  ```
  class ApplicationController < ActionController::Base
    before_filter :authenticate_user!, :authorizate_user!
    ...
  end
  ```
## Usage

![Acl Manager Print Screen](https://raw.githubusercontent.com/flexait/acl_manager/master/acl-manager.png)

### Create a role list to user form
```
= f.collection_check_boxes :role_ids, AclManager::Role.all, :id, :name do |ff|
  = f.label
  = f.check_box
```

### Translate role name
```
activerecord.attributes.acl_manager.role.#{role_name}
```

## License
This project rocks and uses MIT-LICENSE.
