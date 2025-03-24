// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "hubspot",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "hubspot", targets: ["hubspot"])
    ],
    dependencies: [
        .package(url: "https://github.com/HubSpot/mobile-chat-sdk-ios", .upToNextMajor(from: "1.0.5"))
    ],
    targets: [
        .target(
            name: "hubspot",
            dependencies: [
                // Link the HubSpot SDK product
                .product(name: "HubspotMobileSDK", package: "mobile-chat-sdk-ios")
            ],
            path: "Sources/hubspot",  // Ensure that your Swift files are in this directory
            resources: [
                // If your plugin requires any resources like a privacy manifest, add it here
                // Uncomment the following line if you add PrivacyInfo.xcprivacy
                .process("PrivacyInfo.xcprivacy")
                
                // Add additional resources if needed
                // .process("some_resource.png"),
            ]
        )
    ]
)