package enums;

public enum LoanStatus {
	
	EKKREMEI ("��������"),
	
	EGKRITHIKE ("���������"),
	
	APORIFTHIKE ("��������");
	
	private String status;

	private LoanStatus(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}
}