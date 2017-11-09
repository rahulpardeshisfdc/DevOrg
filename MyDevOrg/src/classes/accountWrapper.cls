public class accountWrapper {

    public Boolean checked{ get; set; }
    public Account cat { get; set;}

    public accountWrapper(){
        cat = new Account();
        checked = false;
    }

    public accountWrapper(Account c){
        cat = c;
        checked = false;
    }

    /*public static testMethod void testMe() {

        accountWrapper cw = new accountWrapper();
        System.assertEquals(cw.checked,false);

        accountWrapper cw2 = new accountWrapper(new Account(name='Test1'));
        System.assertEquals(cw2.cat.name,'Test1');
        System.assertEquals(cw2.checked,false);

    }*/

}