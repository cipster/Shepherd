package projectManager.repository;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by Ciprian on 12/14/2014.
 * Project Raindrop
 */
@Entity
public class Articole {
    private int idCod3;
    private String denumire1;
    private String denumire2;
    private String denumire3;
    private String barcode;
    private String detalii;
    private String pretAchizitie;
    private byte stare;

    @Id
    @Column(name = "id_cod_3")
    public int getIdCod3() {
        return idCod3;
    }

    public void setIdCod3(int idCod3) {
        this.idCod3 = idCod3;
    }

    @Basic
    @Column(name = "denumire_1")
    public String getDenumire1() {
        return denumire1;
    }

    public void setDenumire1(String denumire1) {
        this.denumire1 = denumire1;
    }

    @Basic
    @Column(name = "denumire_2")
    public String getDenumire2() {
        return denumire2;
    }

    public void setDenumire2(String denumire2) {
        this.denumire2 = denumire2;
    }

    @Basic
    @Column(name = "denumire_3")
    public String getDenumire3() {
        return denumire3;
    }

    public void setDenumire3(String denumire3) {
        this.denumire3 = denumire3;
    }

    @Basic
    @Column(name = "barcode")
    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    @Basic
    @Column(name = "detalii")
    public String getDetalii() {
        return detalii;
    }

    public void setDetalii(String detalii) {
        this.detalii = detalii;
    }

    @Basic
    @Column(name = "pret_achizitie")
    public String getPretAchizitie() {
        return pretAchizitie;
    }

    public void setPretAchizitie(String pretAchizitie) {
        this.pretAchizitie = pretAchizitie;
    }

    @Basic
    @Column(name = "stare")
    public byte getStare() {
        return stare;
    }

    public void setStare(byte stare) {
        this.stare = stare;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Articole articole = (Articole) o;

        if (idCod3 != articole.idCod3) return false;
        if (barcode != null ? !barcode.equals(articole.barcode) : articole.barcode != null) return false;
        if (denumire1 != null ? !denumire1.equals(articole.denumire1) : articole.denumire1 != null) return false;
        if (denumire2 != null ? !denumire2.equals(articole.denumire2) : articole.denumire2 != null) return false;
        if (denumire3 != null ? !denumire3.equals(articole.denumire3) : articole.denumire3 != null) return false;
        if (detalii != null ? !detalii.equals(articole.detalii) : articole.detalii != null) return false;
        if (pretAchizitie != null ? !pretAchizitie.equals(articole.pretAchizitie) : articole.pretAchizitie != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idCod3;
        result = 31 * result + (denumire1 != null ? denumire1.hashCode() : 0);
        result = 31 * result + (denumire2 != null ? denumire2.hashCode() : 0);
        result = 31 * result + (denumire3 != null ? denumire3.hashCode() : 0);
        result = 31 * result + (barcode != null ? barcode.hashCode() : 0);
        result = 31 * result + (detalii != null ? detalii.hashCode() : 0);
        result = 31 * result + (pretAchizitie != null ? pretAchizitie.hashCode() : 0);
        return result;
    }
}
