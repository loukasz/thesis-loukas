package enums;

public enum LoanOptions {
	
	PROSOPIKO_DANEIO ("��������� ������"),
	
	DANEIO_AGORAS ("�����o ������"),
	
	STEGASTIKO_DANEIO ("���������� ������"),
	
	KATANALWTIKO_DANEIO ("������������ ������");
	
	private String type_;

	private LoanOptions(String type) {
		type_ = type;
	}

	public String getType() {
		return type_;
	}
}