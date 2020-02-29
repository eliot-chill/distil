from db.dbConnect import DBConnect
import pymongo
import hashlib, binascii, os

class User(DBConnect):

    def createStudentUser(self, username, email, password):
        studentCol = super().dbCol("Users","Students")
        studentDict = {"username":username,"email":email,"password":self.hash_password(password)}
        studentCol.insert(studentDict)
    
    def getPassword(self, email):
        studentCol = super().dbCol("Users","Students")
        userPassword = studentCol.find_one({"email":email})
        if(userPassword is not None):
            return userPassword['password']
        else:
            return None

    def hash_password(self, password):
        """Hash a password for storing."""
        salt = hashlib.sha256(os.urandom(60)).hexdigest().encode('ascii')
        pwdhash = hashlib.pbkdf2_hmac('sha512', password.encode('utf-8'), 
                                    salt, 100000)
        pwdhash = binascii.hexlify(pwdhash)
        return (salt + pwdhash).decode('ascii')

    def verify_password(self, stored_password, provided_password):
        """Verify a stored password against one provided by user"""
        salt = stored_password[:64]
        stored_password = stored_password[64:]
        pwdhash = hashlib.pbkdf2_hmac('sha512', 
                                    provided_password.encode('utf-8'), 
                                    salt.encode('ascii'), 
                                    100000)
        pwdhash = binascii.hexlify(pwdhash).decode('ascii')
        return pwdhash == stored_password



    