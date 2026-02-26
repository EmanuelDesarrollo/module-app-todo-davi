import { registerWebModule, NativeModule } from 'expo';

import { ModuleAppTodoDaviModuleEvents } from './ModuleAppTodoDavi.types';

class ModuleAppTodoDaviModule extends NativeModule<ModuleAppTodoDaviModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ModuleAppTodoDaviModule, 'ModuleAppTodoDaviModule');
