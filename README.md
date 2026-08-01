# kps_flutter_getx_design_pattern

A new Flutter project.

## Getting Started

### Design Pattern Default
- MVC: Model/View/Controller
- MVP: Model/View/Presenter
- MVVM: Model/View/ViewModel

### Application of GetX
- State Manager: State Management
- Navigation Manager: Route
    - Get.toNamed("/splash")
    - Get.toRemove("/login")
- Dependency Manager: Service/ServiceImpl -> Create Object
    From ProductService _productService = new ProductService();
    To var productService = Get.find(ProductService());

### Bloc
- LiverPod