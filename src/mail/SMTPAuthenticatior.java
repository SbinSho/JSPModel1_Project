package mail;
 
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
public class SMTPAuthenticatior extends Authenticator{
 
	private String id;
	private String passwd;
	
	public SMTPAuthenticatior(String id, String passwd){
		
		this.id = id;
		this.passwd = passwd;
	}
	
	
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(this.id, this.passwd);
    }
}


