# Implementation Plan - Post Delete Functionality

This plan outlines the steps to add the "Delete" functionality for posts, following the project's GetX design pattern.

## User Review Required

> [!IMPORTANT]
> I am assuming the API endpoint for deleting a post is `DELETE` to `/api/app/post/{id}`. If the endpoint differs, please let me know.

## Proposed Changes

### [Network Layer]

#### [MODIFY] [api_network_service.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/cores/network/api_network_service.dart)
- Add `Future<dynamic> delete(String uri);` to the interface.

#### [MODIFY] [api_network_service_impl.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/cores/network/api_network_service_impl.dart)
- Implement `delete` with authentication headers and 401 refresh logic.

---

### [Data Layer (Repository)]

#### [MODIFY] [post_repository.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/module/post/repository/post_repository.dart)
- Add `Future<bool> deletePost(int id);` to the interface.

#### [MODIFY] [post_repository_impl.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/module/post/repository/post_repository_impl.dart)
- Implement `deletePost` using `apiNetWorkService.delete`.

---

### [Business Logic Layer (Controller)]

#### [MODIFY] [post_controller.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/module/post/post_controller.dart)
- Add `Future<bool> deletePost(int id)` method.
- It should refresh the post list upon successful deletion.

---

### [UI Layer]

#### [MODIFY] [post_view.dart](file:///D:/BBU_Lessons/Mobile_Programming/flutter_getx_design_pattern/lib/app/module/post/post_view.dart)
- Add a delete icon (`Icons.delete`) next to the edit icon in each post card.
- Show a confirmation dialog before deleting to prevent accidental actions.

---

## Verification Plan

### Automated Tests
- Run `analyze_file` on modified files.

### Manual Verification
- Verify that clicking the delete icon triggers a confirmation dialog.
- Verify that confirming the deletion removes the post from the list.
