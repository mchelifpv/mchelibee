include <config.scad>

cammount();

module cammount() {
    difference() {
        union() {
            translate([-4.95+lenshgt,0,0]) union() {
                mirror([0,0,0]) linear_extrude(height=mntthick,center=false) import("camrc3n.svg",convexity=10,center=false);
                mirror([0,1,0]) linear_extrude(height=mntthick,center=false) import("camrc3n.svg",convexity=10,center=false);
            }
            // нижняя защита линзы
            // просто круг
            cylinder(d=1.5+lensdiam+prnsp*2+1.6,h=mntthick);
            // восьмиугольник
            *scale([1,0.95,1]) hull() {
                for (angle=[22.5:45:337.5]) {
                    rotate([0,0,angle]) translate([1.45+lensdiam/2,0,0]) cylinder(d=2,h=mntthick);
                }
            }
            // шестиугольник
            *hull() {
                for (angle=[30:60:330]) {
                    rotate([0,0,angle]) translate([1.45+lensdiam/2,0,0]) cylinder(d=2,h=mntthick);
                }
            }
            // развернутый шестиугольник
            *scale([1,0.9,1]) hull() {
                for (angle=[0:60:300]) {
                    rotate([0,0,angle]) translate([2.15+lensdiam/2,0,0]) cylinder(d=2,h=mntthick);
                }
            }
            // ----------------------------------------------
            // дополнительное кольцо в упор к основанию линзы
            cylinder(d=lensdiam+prnsp*2+1.6,h=lenshgt);
            // хомут
            translate([8.05+lenshgt+17.5,0,3.15/2]) cube([1.6+mntthick+prnsp,1.6+mntwdth+prnsp,3.15],center=true);
            // задняя палка
            translate([8.05+lenshgt+(17.5+(1.6+mntthick+prnsp)/2)/2,0,mntthick/2]) cube([17.5+(1.6+mntthick+prnsp)/2,1.6+mntwdth+prnsp,mntthick],center=true);
            // центральная палка
            hull() {
                translate([-((lenshgt+mntoffst)-9)/2,0,mntthick/2]) cube([(lenshgt+mntoffst)-9,mntwdth,mntthick],center=true);
                translate([-(lenshgt+mntoffst),0,0]) cylinder(d=mntwdth-2.6,h=mntthick);
            }
            // продолжение палки
            hull() {
                translate([-(lenshgt+mntoffst),0,0]) cylinder(d=mntwdth-2.6,h=2*mntthick/3);
                translate([beepoffst > 0?-(lenshgt+mntoffst)-fcmntsize*2-beepoffst-beepdiam/2:-(lenshgt+mntoffst)-fcmntsize*2,0,0]) cylinder(d=mntwdth-2.6,h=2*mntthick/3);
            }
            // крепление пищалки
            if (beepoffst > 0) {
                translate([-(lenshgt+mntoffst)-fcmntsize*2-beepoffst-beepdiam/2,0,0]) cylinder(d=beepdiam+1.6,h=mntthick);
            }
        }
        // отверстие под линзу
        cylinder(d=lensdiam+prnsp*2,h=lenshgt*2.5,center=true);
        // вырез в хомуте
        translate([8.05+lenshgt+17.5,0,2]) cube([mntthick+prnsp,mntwdth+prnsp,5],center=true);
        // вырез для облегчения
        translate([8.05+lenshgt+15/2,0,mntthick-0.1]) cube([15,-2.4+mntwdth+prnsp,mntthick*2],center=true);
        // отверстия в палке
        translate([-(lenshgt+mntoffst),0,-0.1]) cylinder(d=0.9,h=mntthick*2);
        translate([-(lenshgt+mntoffst)-fcmntsize*2,0,-0.1]) cylinder(d=0.9,h=mntthick*2);
        // отверстие под пищалку
        if (beepoffst > 0) {
            translate([-(lenshgt+mntoffst)-fcmntsize*2-beepoffst-beepdiam/2,0,-0.1]) cylinder(d=beepdiam,h=mntthick*2);
        }
    }
}
