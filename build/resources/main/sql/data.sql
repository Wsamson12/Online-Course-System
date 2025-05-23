INSERT INTO users (username, password, full_name, email, phone_number) 
VALUES ('keith', '{noop}keithpw', 'Keith Richards', 'keith@example.com', '1234567890');
-- INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_STUDENT');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_TEACHER');

INSERT INTO users (username, password, full_name, email, phone_number) 
VALUES ('john', '{noop}johnpw', 'John Doe', 'john@example.com', '0987654321');
INSERT INTO user_roles(username, role) VALUES ('john', 'ROLE_STUDENT');

INSERT INTO users (username, password, full_name, email, phone_number)
VALUES ('ben', '{noop}benpw', 'ben li', 'ben@example.com', '1144223311');
INSERT INTO user_roles(username, role) VALUES ('ben', 'ROLE_STUDENT');

INSERT INTO users (username, password, full_name, email, phone_number)
VALUES ('peter', '{noop}peterpw', 'peter chan', 'peter@example.com', '1144232142');
INSERT INTO user_roles(username, role) VALUES ('peter', 'ROLE_STUDENT');