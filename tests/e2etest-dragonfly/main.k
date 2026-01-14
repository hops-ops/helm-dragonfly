import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1
import models.k8s.apimachinery.pkg.apis.meta.v1 as metav1

# ==============================================================================
# E2E test for Dragonfly XRD
# ==============================================================================

_items = [
    metav1alpha1.CompositionTest {
        metadata.name = "e2e-dragonfly"
        spec = {
            compositionPath = "apis/dragonflies/composition.yaml"
            xrdPath = "apis/dragonflies/definition.yaml"
            timeoutSeconds = 600
            validate = True
            xr = {
                apiVersion = "helm.hops.ops.com.ai/v1alpha1"
                kind = "Dragonfly"
                metadata.name = "e2e-dragonfly"
                spec = {
                    clusterName = "e2e-cluster"
                    namespace = "dragonfly"
                }
            }
        }
    }
]

items = _items
