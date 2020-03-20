/**
 * 
 */
package org.yelong.labbol.core.model.support.generator.jsp;

import java.io.File;

import org.yelong.core.model.Model;

/**
 * @author PengFei
 */
public interface JSPGenerator {
	
	void generate(Class<? extends Model> modelClass , File jspFile) throws JSPGenerateException;
	
}
