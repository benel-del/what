package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("whatleague@gmail.com", "euezgblbkrtaltxq"); //관리자의 gmail계정 
	}
}
