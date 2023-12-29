///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//
//package com.eminent.editor;
//
///**
// *
// * @author Tamilvelan
// */
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ckeditor.CKEditorConfig;
//import com.ckeditor.EventHandler;
//import com.ckeditor.GlobalEventHandler;
//
//public class ConfigurationHelper {
//
//
//	public static CKEditorConfig createConfig() {
//		CKEditorConfig config = new CKEditorConfig();
//		List<List<String>> list = new ArrayList<List<String>>();
//		List<String> subList = new ArrayList<String>();
//		subList.add("Source");
//		subList.add("-");
//		subList.add("Bold");
//		subList.add("Italic");
//		list.add(subList);
//		config.addConfigValue("toolbar", "Basic");
//		config.addConfigValue("width","700");
//                config.addConfigValue("height","100");
//                config.addConfigValue("toolbarStartupExpanded",false);
//                config.addConfigValue("disableObjectResizing",true);
//		return config;
//	}
//
//	public static EventHandler createEventHandlers() {
//		EventHandler handler = new EventHandler();
//		handler.addEventHandler("instanceReady","function (ev) { alert(\"Editor Data: \" + ev.editor.getData()); }");
//                handler.addEventHandler("instanceReady","function (ev) { alert(\"Loaded: \" + ev.editor.name); }");
//		return handler;
//	}
//
//	public static GlobalEventHandler createGlobalEventHandlers() {
//		GlobalEventHandler handler = new GlobalEventHandler();
//		handler.addEventHandler("dialogDefinition","function (ev) {  alert(\"Loading dialog window: \" + ev.data.name); }");
//		return handler;
//	}
//}
