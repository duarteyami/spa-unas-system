/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package prgs;


public class formatofecha {
    public String convertirfecha(String fec){
        // 23/03/2011
        String dia="";
        String mes="";
        String anho="";
        dia = fec.substring(0, 2);
        mes= fec.substring(3,5);
        anho=fec.substring(6,10);
        fec=anho+"-"+mes+"-"+dia;
        return fec;

    }
    
     public String convertirfechabd(String fec) {
        // 2012-01-12
        String dia = "";
        String mes = "";
        String anho = "";
        anho = fec.substring(0, 4);
        mes = fec.substring(5, 7);
        dia = fec.substring(8, 10);
        fec = dia + "/" + mes + "/" + anho;
        return fec;

        /*  String dia="";
         String mes="";
         String anho="";
         dia = fec.substring(0, 2);
         mes= fec.substring(3,5);
         anho=fec.substring(6,10);
         fec=anho+"-"+mes+"-"+dia;
         return fec;*/

    }
      public String convertirfechabdd(String fec) {
        // 2012-01-12
        String dia = "";
        String mes = "";
        String anho = "";
        anho = fec.substring(0, 4);
        mes = fec.substring(5, 7);
        dia = fec.substring(8, 10);
         fec = anho + "-" + mes + "-" + dia;
        //fec = dia + "/" + mes + "/" + anho;
        return fec;

        /*  String dia="";
         String mes="";
         String anho="";
         dia = fec.substring(0, 2);
         mes= fec.substring(3,5);
         anho=fec.substring(6,10);
         fec=anho+"-"+mes+"-"+dia;
         return fec;*/

    }
}
