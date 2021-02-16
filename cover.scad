include <config.scad>

// Cell size / Размер ячеек
size=4.6;
// Offset / Смещение ячеек
offst=5.52;
// Left-right offset / разбег ячеек в стороны
rloffst=0.5;

//cover();
coverprint();

module cellone1(){
    rotate([0,0,30]) cylinder(d=size,h=1,$fn=6,center=true);
}

module cellone2(){
    rotate([0,0,0]) cylinder(d=size,h=1,$fn=6,center=true);
}

module cells1(){
    //translate([ offst/2,0,0]) cellone1();
    //translate([-offst/2,0,0]) cellone1();
    //translate([ offst*1.5,0,0]) cellone1();
    //translate([-offst*1.5,0,0]) cellone1();
    translate([0, rloffst,0]) union() {
        translate([0, sqrt(3)*offst/2,0]) cellone1();
        translate([ offst, sqrt(3)*offst/2,0]) cellone1();
        translate([-offst, sqrt(3)*offst/2,0]) cellone1();
        translate([ offst/2, 2*sqrt(3)*offst/2,0]) cellone1();
        translate([-offst/2, 2*sqrt(3)*offst/2,0]) cellone1();
    }

    translate([0,-rloffst,0]) union() {
        translate([0,-sqrt(3)*offst/2,0]) cellone1();
        translate([ offst,-sqrt(3)*offst/2,0]) cellone1();
        translate([-offst,-sqrt(3)*offst/2,0]) cellone1();
        translate([ offst/2,-2*sqrt(3)*offst/2,0]) cellone1();
        translate([-offst/2,-2*sqrt(3)*offst/2,0]) cellone1();
    }
}

module cells2(){
    translate([0, offst,0]) cellone2();
    translate([0,-offst,0]) cellone2();
    translate([0, offst*2,0]) cellone2();
    translate([0,-offst*2,0]) cellone2();
    translate([ sqrt(3)*offst/2,-offst/2,0]) cellone2();
    translate([-sqrt(3)*offst/2,-offst/2,0]) cellone2();
    translate([ sqrt(3)*offst/2, offst/2,0]) cellone2();
    translate([-sqrt(3)*offst/2, offst/2,0]) cellone2();
    translate([ sqrt(3)*offst,0,0]) cellone2();
    translate([-sqrt(3)*offst,0,0]) cellone2();
    translate([ sqrt(3)*offst/2,-offst*1.5,0]) cellone2();
    translate([-sqrt(3)*offst/2,-offst*1.5,0]) cellone2();
    translate([ sqrt(3)*offst/2, offst*1.5,0]) cellone2();
    translate([-sqrt(3)*offst/2, offst*1.5,0]) cellone2();
    translate([ sqrt(3)*offst, offst,0]) cellone2();
    translate([ sqrt(3)*offst,-offst,0]) cellone2();
    translate([-sqrt(3)*offst, offst,0]) cellone2();
    translate([-sqrt(3)*offst,-offst,0]) cellone2();
}

module cover() {
    difference() {
        union() {
            // основа
            rotate([0,0,45]) cube([27,27,coverthick],center=true);
            // продольная палка
            hull() {
                translate([ fcmntsize+0.35,0,0]) cylinder(d=4.4,h=coverthick,center=true);
                translate([-fcmntsize,0,0]) cylinder(d=4.4,h=coverthick,center=true);
            }
            // поперечная палка
            hull() {
                translate([0, fcmntsize,0]) cylinder(d=4.4,h=coverthick,center=true);
                translate([0,-fcmntsize,0]) cylinder(d=4.4,h=coverthick,center=true);
            }
            // пенек, чтобы приподнять сзади для вывода силовых проводов
            translate([-fcmntsize,0,-coverthick/2]) cylinder(d=4.4,h=coverthick*4);
            // дополнение для того, чтобы пенек успевал остывать. Обрезается после печати
            *translate([-30,0,-coverthick/2]) cylinder(d=4.4,h=coverthick*3);
            //translate([-24,0,0]) cube([8,0.8,coverthick],center=true);
        }
        // блок ячеек
        cells1();
        *cells2();
        // переднее овальное отверстие
        translate([fcmntsize,0,0]) hull() {
            translate([ 0.35,0,0]) cylinder(d=m14hole,h=coverthick*3,center=true);
            translate([-0.35,0,0]) cylinder(d=m14hole,h=coverthick*3,center=true);
        }
        // заднее отверстие
        translate([-fcmntsize,0,0]) cylinder(d=m14hole,h=coverthick*10,center=true);
        // боковые отверстия
        translate([0, fcmntsize,0]) cylinder(d=m14hole,h=coverthick*3,center=true);
        translate([0,-fcmntsize,0]) cylinder(d=m14hole,h=coverthick*3,center=true);
    }
}

module coverprint() {
    translate([0,0,coverthick*1.5]) cube([8,0.8,coverthick*4],center=true); 
    for(angle=[0:180:180]) {
      rotate([0,0,angle]) translate([24,0,0]) cover();
    }
}
