/**
 * 
 */
package org.yelong.labbol.core.model.support.generator.jsp.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.freemarker.FreeMarkerConfigurationFactoryBean;
import org.yelong.core.model.Model;
import org.yelong.labbol.core.model.support.generator.jsp.JSPGenerateException;
import org.yelong.labbol.core.model.support.generator.jsp.JSPGenerator;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * @author PengFei
 */
public class DefaultJSPGenerator implements JSPGenerator{

	private static final FreeMarkerConfigurationFactoryBean factory = new FreeMarkerConfigurationFactoryBean();

	private static Configuration freemarkerConfiguration = null;

	private static final String FTL_NAME = "jsp.ftl";

	static {
		factory.setTemplateLoaderPath("org/yelong/labbol/core/model/support/generator/jsp/impl/tpl");
		try {
			freemarkerConfiguration = factory.createConfiguration();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void generate(Class<? extends Model> modelClass, File jspFile) throws JSPGenerateException {
		try {
			Template template = freemarkerConfiguration.getTemplate(FTL_NAME,"UTF-8");
			Map<String,Object> root = new HashMap<>();
			String modelClassName = modelClass.getSimpleName();
			root.put("modelClassNameLowerPrefix", modelClassName.substring(0, 1).toLowerCase() + modelClassName.substring(1, modelClassName.length()));
			Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(jspFile), "utf-8"));
			//生成word文件
			template.process(root,writer);
			writer.flush();
			writer.close();
		} catch (Exception e) {
			throw new JSPGenerateException(e);
		}
		
	}
}
