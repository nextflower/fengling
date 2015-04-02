package com.fengling.cms.template;


public class CmsModuleGenerator {
	private static String packName = "com.fengling.cms.template";
	private static String fileName = "fengling.properties";

	public static void main(String[] args) {
		new ModuleGenerator(packName, fileName).generate();
	}
}
