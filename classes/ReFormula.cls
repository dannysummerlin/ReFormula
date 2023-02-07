public class ReFormula {
	public class ReFormulaException extends Exception {}

	@InvocableMethod(label='Recalculate Formulas' description='Update the values for a Record\'s formulas without having to trigger a write operation')
	public static List<sObject> recalculate(List<sObject> inputs) {
		List<sObject> outputs = new List<sObject>();
		for(sObject input : inputs) {
			List<FormulaRecalcResult> recalcResults = Formula.recalculateFormulas(new List<sObject>{input});
			if(recalcResults[0].isSuccess()) {
				outputs.add(input);
			} else {
				System.debug('------------------------- Recalculation Error ----------------------------');
				System.debug(recalcResults[0].getErrors());
				System.debug('--------------------------------------------------------------------------');
				throw newReFormulaException(recalcResults[0].getErrors());
			}
		}
		return outputs;
	}
	static ReFormulaException newReFormulaException(List<System.FormulaRecalcFieldError> messages) {
		String message = String.join(messages, '\n');
		return newReformulaException(message);
	}
	static ReFormulaException newReFormulaException(String message) {
		ReFormulaException err = new ReFormulaException(message);
		err.setMessage(message);
		return err;
	}
}
