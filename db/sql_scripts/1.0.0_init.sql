create database fitness_club_db;


create schema person;

create table person.roles (
    role_id int identity(1,1) primary key,
    role_name nvarchar(50) unique not null
);

create table person.users (
    user_id uniqueidentifier default NEWSEQUENTIALID() primary key,
    role_id int not null foreign key references person.roles(role_id),
    first_name nvarchar(50) not null,
    last_name nvarchar(50) not null,
    email nvarchar(100) not null,
    phone_number nvarchar(20)
);


create table person.trainers (
    trainer_id uniqueidentifier default NEWSEQUENTIALID() primary key,
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    training_session_time int,
    training_session_price decimal(10,2) not null
);


create schema subscription;

create table subscription.subscriptions (
    subscription_id int identity(1,1) primary key,
    subscription_name NVARCHAR(150) not null,
    subscription_price decimal(10,2) not null,
    subscription_description NVARCHAR(200),
    subscription_count_of_training int not null,
);


create schema client;



create table client.visit_logs (
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    day date not null,
    trainer_id uniqueidentifier foreign key references person.trainers(trainer_id)
);

create table client.active_subscription (
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    subscription_id int foreign key references subscription.subscriptions(subscription_id),
    number_of_workouts_used int default 0
    primary key (user_id, subscription_id)
);


create table client.client_info (
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    subscription_id  int foreign key references subscription.subscriptions(subscription_id),
    trainer_id uniqueidentifier foreign key references person.trainers(trainer_id),
    count_of_total_training int default 0
);

create table client.clients_bonuses (
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    bonuse_discount decimal(5,2) default 0.00
);


create schema trainers_info;

create table trainers_info.trainer_clients (
    trainer_id uniqueidentifier foreign key references person.trainers(trainer_id) not null,
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    primary key (trainer_id, user_id)
);

create table trainers_info.trainer_shedule_template (
    trainer_id uniqueidentifier foreign key references person.trainers(trainer_id) not null,
    day_of_week varchar(10),
    hour time,
    available bit default 1,
    primary key (trainer_id, day_of_week, hour)
);

create table trainers_info.trainer_booking (
    booking_id uniqueidentifier default newsequentialid() primary key,
    trainer_id uniqueidentifier foreign key references person.trainers(trainer_id) not null,
    user_id uniqueidentifier foreign key references person.users(user_id) not null,
    session_date DATE not null,
    hour TIME not null,
    status varchar(20) check (status in ('booked', 'cancelled', 'completed'))
);



