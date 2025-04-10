**[FLO - Distributed Hierarchical Dataflow](https://github.com/kk-0129/Flo)**

Swift package:
# FloApp

This package provides almost all the code necessary to build and run a macos Flo application. We do not provide a pre-compiled executable app here, but the steps to build one are straightforward:

1. In [XCode](https://developer.apple.com/xcode/), create a new document-based application project (with `XIB` interface)

2. Configure the project to use the `FloApp` package in this repository:
  * select `Add Package Dependencies` from the `File` menu, and click the `+` button (`Add Package Collection`, bottom left corner of the popup) to add the URL `https://github.com/kk-0129/FloApp` of this repository.

3. Replace **all** the code in the (auto-generated) `AppDelegate.swift` file with the following (3 lines):

<pre><code>import FloApp
@main
class AppDelegate: FloAppDelegate {  }
</code></pre>

3. Replace **all** the code in the (auto-generated) `Document.swift` file with the following (2 lines):

<pre><code>import FloApp
class Document : FloDocument{  }
</code></pre>

4. Set the document view's class in the `Document.xib` file to `FloApp.FloDocumentView`.

5. Copy the [Resources](Resources) folder from this repository into your project.
  * This folder contains 2 configuration files: `structs.xml` for user-defined structs, and `devices.xml` to define remote devices. You can edit these files as needed (explained below), but make sure that they are included in the `Copy Bundle Resources` section under the `Build Phases` tab of the project's target.

6. In the `App Sandbox` (under the `Signing & Capabilities` tab of the project's target), make sure that both the `Incoming Connections (Server)` and `Outgoing Connections (Client)` check boxes are selected (to allow the application to communicate with remote devices).

7. Build and launch the application.

## User-defined Structs

The Resources

## Remote devices 
