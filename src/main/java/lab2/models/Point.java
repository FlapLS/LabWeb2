package lab2.models;

public class Point {
    private double x;
    private double y;
    private  double r;
    private String result;
    private String currentTime;

    public Point(double x, double y, double r, String result,String currentTime){
        this.x=x;
        this.y=y;
        this.r=r;
        this.result=result;
        this.currentTime=currentTime;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public String getResult() {
        return result;
    }

    public String getCurrentTime() {
        return currentTime;
    }
}
