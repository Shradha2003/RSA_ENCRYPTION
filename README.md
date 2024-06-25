# RSA_ENCRYPTION
This repository contains a Verilog implementation of an RSA encryption algorithm. The module is designed to perform encryption using RSA, a widely-used public-key cryptosystem. It includes key validation, modular exponentiation, and modular arithmetic operations.
# Module Description
### RSA_ALGORITHM
The RSA_ALGORITHM module performs RSA encryption on a given message using a provided encryption key and two prime numbers. The module operates in multiple stages to ensure the encryption process is carried out correctly.
# Sub-modules
### Encryption_Valid
This module validates the encryption key and calculates the modulus (N) and the totient (T) of the provided prime numbers.

### power_process
This module handles the modular exponentiation required for RSA encryption.

### mod_operationrsa
This module performs the modular reduction operation necessary in RSA encryption.

# Additional Details
### isPrime
Helper module to check the primality of the encryption key.

