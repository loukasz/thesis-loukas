package enums;

public enum LoanOptions {
	
	PROSOPIKO_DANEIO ("��������� ������"),
	
	DANEIO_AGORAS ("�����o ������"),
	
	STEGASTIKO_DANEIO ("���������� ������"),
	
	DANEIO_AGORA_AFTOKINITOU ("������ ������ �����������"),
	
	KATANALWTIKO_DANEIO ("������������ ������");
	
	private String type;

	private LoanOptions(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
}