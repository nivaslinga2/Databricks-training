-- Question 1
select mixed_value, substring(mixed_value from '^[0-9]+') as extracted_number
from regex_practice;

-- Question 2
select mixed_value, substring(mixed_value from '[0-9]+$') as extracted_number
from regex_practice;

-- Question 3
select mixed_value, substring(mixed_value from '^.') as first_character
from regex_practice;

-- Question 4
select mixed_value, substring(mixed_value from '.$') as last_character
from regex_practice;

-- Question 5
select mixed_value, substring(mixed_value from '[0-9]{2}') as consecutive_digits
from regex_practice;

-- Question 6
select mixed_value, substring(mixed_value from '[0-9]{1}') as one_character
from regex_practice;

-- Question 7
select phone, substring(phone from '^\\+?([0-9]+)') as country_code
from regex_practice;

-- Question 8
select mixed_value, substring(mixed_value from '[A-Za-z]+([0-9]+)[A-Za-z]+') as numeric_part
from regex_practice;

-- Question 9
select email, substring(email from '^[^@]+') as username
from regex_practice;

-- Question 10
select email, substring(email from '@(.+)$') as domain_name
from regex_practice;

-- Question 11
select email, substring(email from '@(.+)$') as domain_name
from regex_practice;

-- Question 12
select email, substring(email from '[a-zA-Z]+$') as extension
from regex_practice;

-- Question 13
select mixed_value, substring(mixed_value from '[a-zA-Z]+') as alphabetic_char
from regex_practice;

-- Question 14
select mixed_value, substring(mixed_value from '[0-9]+') as continuous_numeric_char
from regex_practice;

-- Question 15
select full_text, substring(full_text from '^.{3}') as first_3_characters
from regex_practice;

-- Question 16
select full_text, substring(full_text from '.{2}$') as last_2_characters
from regex_practice;

-- Question 17
select full_text, substring(full_text from '^[A-Za-z]+([0-9]+)_') as number_portion
from regex_practice;

-- Question 18
select full_text, substring(full_text from '[0-9]+$') as code_at_end
from regex_practice;

-- Question 19
select full_text, substring(full_text from '_([A-Za-z]+)_') as text_between_underscores
from regex_practice;

-- Question 20
select phone, substring(phone from '^\\+([0-9]+)') as country_code
from regex_practice;
