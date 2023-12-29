/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function(config) {
    // Define changes to default configuration here.
    // For complete reference see:
    // http://docs.ckeditor.com/#!/api/CKEDITOR.config

    // The toolbar groups arrangement, optimized for two toolbar rows.
    config.width = 700;
    config.height = 100;
    config.toolbarCanCollapse = true;
    config.toolbarStartupExpanded = false;
    config.disableNativeSpellChecker = false; 
    config.scayt_autoStartup = true;
    config.scayt_maxSuggestions= 3;
    // Remove some buttons provided by the standard plugins, which are
    // not needed in the Standard(s) toolbar.
    config.removePlugins = 'elementspath';
    // Set the most common block elements.

    // Simplify the dialog windows.
};
