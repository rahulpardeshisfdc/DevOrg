public class SoftwareDownloadAccessHandler {
    public void SoftwareDownloadAccessHelperCall(list<Asset> lstAsset){
        SoftwareDownloadAccessHelper sdhelper = new SoftwareDownloadAccessHelper();
        if(Trigger.isBefore){
        	sdhelper.provideSoftwareDownloadAccess(lstAsset);
        }
    }
}