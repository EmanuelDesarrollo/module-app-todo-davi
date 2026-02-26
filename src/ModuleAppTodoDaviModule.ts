import { NativeModule, requireNativeModule } from 'expo';

import { ModuleAppTodoDaviModuleEvents } from './ModuleAppTodoDavi.types';

declare class ModuleAppTodoDaviModule extends NativeModule<ModuleAppTodoDaviModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ModuleAppTodoDaviModule>('ModuleAppTodoDavi');
