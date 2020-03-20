/**
 * 
 */
package org.yelong.labbol.core.model.support.generator.extjs;

import java.io.File;

import org.yelong.core.model.resolve.ModelAndTable;

/**
 * @author PengFei
 */
public interface ExtjsGenerator {
	
	void generate(ModelAndTable modelAndTable , File jsFile) throws ExtjsGenerateException;
	
}
