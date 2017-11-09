trigger SoftwareDownloadAccess on Asset (before insert) {
	SoftwareDownloadAccessHandler sdhandler = new SoftwareDownloadAccessHandler();
    sdHandler.SoftwareDownloadAccessHelperCall(Trigger.new);
}