import AppKit
import CoreGraphics

let W = 2400, H = 1500
let colorSpace = CGColorSpaceCreateDeviceRGB()
let bitmap = CGContext(data:nil,width:W,height:H,bitsPerComponent:8,bytesPerRow:W*4,space:colorSpace,bitmapInfo:CGImageAlphaInfo.noneSkipLast.rawValue)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(cgContext:bitmap,flipped:false)
let ctx = bitmap
ctx.setFillColor(NSColor(calibratedRed: 0.97, green: 0.98, blue: 0.99, alpha: 1).cgColor)
ctx.fill(CGRect(x:0,y:0,width:W,height:H))
func color(_ hex: UInt32, _ alpha: CGFloat = 1) -> NSColor {
 return NSColor(calibratedRed: CGFloat((hex >> 16)&255)/255, green: CGFloat((hex >> 8)&255)/255, blue: CGFloat(hex&255)/255, alpha: alpha)
}
func rect(_ x:CGFloat,_ y:CGFloat,_ w:CGFloat,_ h:CGFloat,_ fill:UInt32,_ stroke:UInt32=0xCBD5E1,_ radius:CGFloat=14,_ line:CGFloat=2) {
 let p=NSBezierPath(roundedRect:NSRect(x:x,y:y,width:w,height:h),xRadius:radius,yRadius:radius)
 color(fill).setFill(); p.fill(); color(stroke).setStroke(); p.lineWidth=line; p.stroke()
}
func text(_ value:String,_ x:CGFloat,_ y:CGFloat,_ size:CGFloat,_ hex:UInt32=0x172B4D,_ bold:Bool=false) {
 let font = bold ? NSFont.boldSystemFont(ofSize:size) : NSFont.systemFont(ofSize:size)
 let a:[NSAttributedString.Key:Any] = [.font:font,.foregroundColor:color(hex)]
 (value as NSString).draw(at:NSPoint(x:x,y:y),withAttributes:a)
}
func line(_ x1:CGFloat,_ y1:CGFloat,_ x2:CGFloat,_ y2:CGFloat,_ hex:UInt32=0x466080,_ dashed:Bool=false) {
 ctx.saveGState(); ctx.setStrokeColor(color(hex).cgColor); ctx.setLineWidth(4)
 if dashed { ctx.setLineDash(phase:0,lengths:[11,8]) }
 ctx.move(to:CGPoint(x:x1,y:y1)); ctx.addLine(to:CGPoint(x:x2,y:y2)); ctx.strokePath()
 let angle=atan2(y2-y1,x2-x1), size:CGFloat=14
 let p=NSBezierPath(); p.move(to:NSPoint(x:x2,y:y2))
 p.line(to:NSPoint(x:x2-size*cos(angle-0.45),y:y2-size*sin(angle-0.45)))
 p.line(to:NSPoint(x:x2-size*cos(angle+0.45),y:y2-size*sin(angle+0.45))); p.close()
 color(hex).setFill(); p.fill(); ctx.restoreGState()
}
func service(_ x:CGFloat,_ y:CGFloat,_ title:String,_ subtitle:String,_ accent:UInt32) {
 rect(x,y,250,94,0xFFFFFF,accent,14,3)
 let icons:[String:String] = ["EKS":"eks.png","EC2 nodes":"ec2.png","NAT / ALB":"elb.png","EBS + logs":"cloudwatch.png","K8s operations":"eks.png","ALB":"elb.png","Route 53":"route53.png","EC2 ASG":"autoscaling.png","S3":"s3.png","CloudWatch":"cloudwatch.png","Compute Opt.":"compute-optimizer.png","Budgets":"budgets.png"]
 if let name=icons[title], let image=NSImage(contentsOfFile:"architecture/icons/\(name)") {
   image.draw(in:NSRect(x:x+10,y:y+17,width:58,height:58))
 } else {
   rect(x+14,y+22,48,48,accent,accent,12,1)
   text(String(title.prefix(1)),x+30,y+34,25,0xFFFFFF,true)
 }
 text(title,x+76,y+49,20,0x172B4D,true)
 text(subtitle,x+76,y+23,14,0x52657A,false)
}
text("AWS COST OPTIMIZATION & MIGRATION DECISION",74,1400,48,0x15294A,true)
text("Hands-on analysis • candidate architectures • no AWS deployment claimed",76,1358,24,0x52657A,false)
rect(74,1250,2252,74,0xFFF3E4,0xE98B27,16,2)
text("COST & USAGE EVIDENCE",100,1280,22,0x8E4B00,true)
if let icon=NSImage(contentsOfFile:"architecture/icons/cost-explorer.png") { icon.draw(in:NSRect(x:438,y:1260,width:44,height:44)) }
text("Cost Explorer  •  Cost Optimization Hub  •  Budgets & tags  •  Compute Optimizer",520,1280,21,0x172B4D,false)
text("Reference integrations only; sample analyzer uses invented values.",1590,1280,18,0x6C5A46,false)
line(1180,1248,1180,1200,0xE98B27)
rect(870,1115,620,82,0xFFF3E4,0xE98B27,15,2)
text("WORKLOAD + COST ANALYSIS",1002,1145,24,0x8E4B00,true)
text("Utilization • peaks • network • storage • operations • SLOs",930,1126,17,0x5E6470,false)
line(1080,1114,700,1068,0xE98B27); line(1280,1114,1700,1068,0xE98B27)
rect(74,360,1050,695,0xF5F1FA,0x7652A5,20,3)
text("EKS / KUBERNETES",102,1010,30,0x56388C,true)
text("CURRENT / CANDIDATE COMPARISON • dashed = reference path",102,978,17,0x685B7D,false)
service(115,850,"EKS","control plane",0x7652A5)
service(405,850,"EC2 nodes","worker capacity",0x7652A5)
service(695,850,"NAT / ALB","network spend",0x7652A5)
service(115,690,"EBS + logs","storage / telemetry",0x7652A5)
service(405,690,"Cross-AZ","data transfer",0x7652A5)
service(695,690,"K8s operations","platform toil",0x7652A5)
text("Investigate drivers before deciding to migrate.",115,590,20,0x493A60,true)
text("EKS may fit many services, rich scheduling, Kubernetes APIs,",115,550,17,0x493A60,false)
text("platform capabilities, and teams with cluster operations maturity.",115,522,17,0x493A60,false)
text("Keep EKS where workload needs or migration risk justify it.",115,460,17,0x493A60,true)
rect(1270,360,1056,695,0xECF8F1,0x27945C,20,3)
text("EC2 + DOCKER",1300,1010,30,0x167241,true)
text("OPTIMIZED CANDIDATE • not deployed",1300,978,17,0x347A58,false)
rect(1335,880,930,68,0xEAF2FC,0x1C64A5,13,3)
text("AWS REGION • VPC • 2 Availability Zones",1570,904,21,0x174A78,true)
rect(1338,600,446,240,0xFFFFFF,0x74A8D3,14,2)
rect(1812,600,430,240,0xFFFFFF,0x74A8D3,14,2)
rect(1348,700,426,130,0xEEF6FC,0x9FC3DF,10,1)
rect(1822,700,410,130,0xEEF6FC,0x9FC3DF,10,1)
rect(1348,605,426,90,0xEFF8F1,0xA7D2B5,10,1)
rect(1822,605,410,90,0xEFF8F1,0xA7D2B5,10,1)
text("AVAILABILITY ZONE A",1360,847,16,0x174A78,true)
text("AVAILABILITY ZONE B",1950,847,16,0x174A78,true)
text("PUBLIC SUBNET",1360,808,15,0x27638E,true)
text("PUBLIC SUBNET",1950,808,15,0x27638E,true)
service(1660,710,"ALB","HTTP routing",0xE98B27)
service(1990,1055,"Route 53","global DNS",0x7652A5)
service(1390,605,"EC2 ASG","private subnet",0x27945C)
service(1920,605,"EC2 ASG","private subnet",0x27945C)
rect(1375,500,810,66,0xF5FBF7,0x8AC5A5,12,2)
text("Docker containers • rightsize / schedule / ARM64 evaluate",1450,522,19,0x1B6941,true)
line(2115,1055,2250,975,0x1C64A5)
line(2250,975,2250,870,0x1C64A5)
line(2250,870,1785,870,0x1C64A5)
line(1785,870,1785,805,0x1C64A5)
line(1730,710,1515,704,0x1C64A5)
line(1820,710,2045,704,0x1C64A5)
line(1515,605,1515,566,0x27945C)
line(2045,605,2045,566,0x27945C)
text("Do not equate lower compute cost with lower total cost.",1380,448,18,0x315943,true)
text("Include host operations, headroom, reliability and migration.",1380,416,17,0x315943,false)
rect(74,180,2252,145,0xFFFFFF,0xAEBECD,16,2)
text("SHARED COST / GOVERNANCE LENSES",104,288,20,0x432B76,true)
service(100,195,"S3","object lifecycle",0x27945C)
service(390,195,"CloudWatch","logs / retention",0x7652A5)
service(680,195,"Compute Opt.","recommendations",0x7652A5)
service(970,195,"Budgets","alerts / tags",0x7652A5)
text("Decide by workload, utilization, scaling, team capability, availability, security and migration complexity.",1280,250,20,0x172B4D,true)
text("Illustrative cost inputs only • no account data • no measured savings • no AWS resources created",1280,210,17,0x52657A,false)
text("Blue = traffic / architecture    Orange = cost analysis    Green = candidate    Purple = governance / comparison",86,100,18,0x43556B,false)
NSGraphicsContext.restoreGraphicsState()
let rep=NSBitmapImageRep(cgImage:bitmap.makeImage()!)
let data=rep.representation(using:.png,properties:[:])!
let destination = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "architecture/architecture.png"
try data.write(to:URL(fileURLWithPath:destination))
