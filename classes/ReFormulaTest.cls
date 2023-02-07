@isTest
private class ReFormulaTest {
	@isTest static void SimpleTest() {
		Account testData = new Account();
		testData.Name = 'First Account';
		List<sObject> results = ReFormula.recalculate(new List<sObject>{testData});
	}
	@isTest static void ExceptionTest() {
        Boolean exceptionOccurred = false;
        try {
			Account testData = new Account();
			testData.Name = 'First Account';
			testData.Id = 'Bad Id';
			List<sObject> results = ReFormula.recalculate(new List<sObject>{testData});
        } catch(Exception e) {
            ReFormula.ReFormulaException testException = new ReFormula.ReFormulaException(e.getMessage());
            exceptionOccurred = true;
        }
        System.assert(exceptionOccurred, 'An Exception was not thrown');
	}
}
